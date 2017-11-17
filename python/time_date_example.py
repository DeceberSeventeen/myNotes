# 获取当前时间的两种方法
import datetime,time

now = time.strftime("%Y-%m-%d %H:%M:%S")
print now

now = datetime.datetime.now()
print now

# 获取当前时间前一小时、前一天、前一周、前一个月
import datetime

now = datetime.datetime.now()

# 前一小时
d1 = now - datetime.timedelta(hours=1)
print d1.strftime("%Y-%m-%d %H:%S:%M")

# 前一天
d2 = now - datetime.timedelta(days=1)
print d2.strftime("%Y-%m-%d %H:%S:%M")

# 上周日
d3 = now - datetime.timedelta(days=now.isoweekday())
print d3.strftime("%Y-%m-%d %H:%S:%M"), " ", d3.isoweekday()

# 上周一
d31 = d3 - datetime.timedelta(days=6)
print d31.strftime("%Y-%m-%d %H:%S:%M"), " ", d31.isoweekday()

# 上个月最后一天
d4 = now - datetime.timedelta(days=now.day)
print d3.strftime("%Y-%m-%d %H:%S:%M")

# 上个月第一天
print datetime.datetime(d4.year, d4.month, 1) 

# 获取代码的执行时间
import time

# 可以使用时间戳来获取代码的执行时间
starttime = time.time()
for i in range(0, 10):
    time.sleep(1)
endtime = time.time()
print "time1 :", endtime - starttime


# time.time()和time.clock()在不同的操作系统下，有不同的结果
# 在ubuntu下，time()获取的是时钟过去的时间，clock()获取的是CPU在当前进程上的执行时间
print(time.time(), time.clock())


# 时间字符串转时间戳，时间戳转时间字符串，datetime对象转时间戳
# 字符串时间转时间搓
datestr1 = '2015-06-06 10:10:10'
print 'datestr to time :', time.mktime(time.strptime(datestr1, "%Y-%m-%d %H:%M:%S"))

# 时间搓转格式化时间字符串
time1 = time.time()
print 'time to datestr :', time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time1))

# datetime对象转时间搓
datetime1 = datetime.datetime.now()
print 'datetime to time :', time.mktime(datetime1.timetuple())

# 时间戳转datetime对象
t1 = time.time()
t2 = t1 + 20
d1 = datetime.datetime.fromtimestamp(t1)
d2 = datetime.datetime.fromtimestamp(t2)
print 'time1 to datetime1 :', datetime.datetime.fromtimestamp(t1)
print 'time2 to datetime2 :', datetime.datetime.fromtimestamp(t2)
print 'seconds diff :', (d2 - d1).seconds