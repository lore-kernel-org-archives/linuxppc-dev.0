Message-ID: <4118282C375DF64EA700135193EEB8CAAFFF20@ACUSH02>
From: "Dixon, Myron @ GNS" <Myron.Dixon@L-3com.com>
To: m madhuker <mythri_madhuker@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Your valuable Suggestions / Advise for Beginners in Device Dr
	iver Development under Embedded Linux P
Date: Mon, 12 Jul 2004 09:39:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Approximately 1.5 years ago I found myself in a similar
situation as you.  So, I'm no guru, but I've learned work with
the tool chain and build device drivers for our custom hardware
using a 2.4.18 kernel on an 8260 custom board.

I would first of all recommend two books that you should read to
answer some of your basic questions. Both are available for
review at www.oreilly.com.

First, is Building Embedded Linux Systems by Karim Yaghmour. It covers
how to build your tool chain through getting Linux running on
your target for multiple processor architectures.  Excellent resource.

The second is Linux Device Drivers by Alessandro Rubin and
Jonathan Corbet.  This is another great source dedicated to device
driver development in a linux environment.  The one draw back about
this one is the latest edition (that I have- 2nd) is limited to 2.4
kernels.  You mention RTOSs so, I'm assuming you'd be looking into
2.6 kernels.

That's pretty much all I have to offer, maybe some of the real gurus can
assist you with some of the tougher questions you have

Myron

-----Original Message-----
From: m madhuker [mailto:mythri_madhuker@yahoo.com]
Sent: Monday, 12 July, 2004 2:44 AM
Subject: Your valuable Suggestions / Advise for Beginners in Device
    Driver Development under Embedded Linux P

I have been assigned some project based in Device Driver Development for
USB, Printers, IDE, Ethernet under Embedded Linux. Since I am a beginner
in this area, I would like to know some details based on the following
clarifications.

1] Pre-requisite skills / knowledge and concepts to understand before
embarking on the above project.

2] Typical Project Environment for Device Driver Development under
Embedded Linux Platform.

3] Ups & Downs of Embedded Linux w.r.t other RTOSes ( VxWorks, Psos,
Nucleus, QNX, OSEK etc . . . .) Please highlight me about the Benchmark
details.

4] Suppose I need to start off with the above project ( Device Drivers
for Printers, Scanners, PDAs, LCDs, Keypads ), what are the essential
points to be kept in mind for smooth running of the project.

5] What are the Initialization / Installation steps to be done regarding
Embedded Linux. Please declare the latest version to be used. Upon
selecting the RTOS, how should I deal with the selection of Target Board
along with the Supporting Tools ?

6] Is it sufficient to use C, ignoring C++ & Java ? Is Assembly Language
essential ? Which part of C is commonly used in Device Drivers ?

7] Please let me know the typical driver size ( Footprint ) for Printer.
What could be the duration of the project ?

8] Highlight me about some of the useful websites, books / references
and contact Email IDs of Experienced Professionals involved in such
Projects.

9] How does the Testing / Debugging takes place ? What are the Test /
Debug Tools available for such Operations ?

10] Please let me know the Optimization Techniques involved in the
Device Driver Development.

11] In this case of the Project, Linux Porting must be done prior to
writing Device Drivers. Am I right ? Kindly comment.

12] What Technical details should I need to understand under RTOS, C,
Embedded Linux ? Is it necessary to know any Protocol for Device Driver
Development ?

13] How often do you use Oscillators / Logic Analyzer ? Please highlight
me about the Connection / Installation details.

Please furnish the above details as soon as possible and oblige. Your
assistance in this regard would greatly benefit towards my successful
career under this area.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
