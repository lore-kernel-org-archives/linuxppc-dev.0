Message-Id: <200008031432.QAA09315@denx.local.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linker help: How to create "hole" in text segment?
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Aug 2000 16:32:17 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

any linker experts out there?

This is for the PPCBoot project, and the background for  my  question
is the segmented structure of Flash memory chips:

I need to place some (read-only) data at a fixed address right in the
middle of the memory region that is intended to hold the text segment
- i.e, I want my memory map to look like this:

start + 0:	Begin of Text Segment
...
start + 32k-1	End of Text Segment (Part 1)

start + 32k	Begin of 16 k RO-Data
...
start + 48k -1	End of RO-Data

start + 48k	Begin of Text Segment (Part 2, continued)
...


Ideally, I want the linker to  make  the  code  "flow"  automatically
around the 16k gap - any hints how that can be arranged?

Thanks in advance,

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quote from a recent meeting:   "We are going to continue having these
meetings everyday until I find out why no work is getting done."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
