From: erik.teose@exgate.tek.com
Message-ID: <BA0E4392AD99D040885C414D992C24BE059740DF@us-bv-m11.bv.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: OT: Question concerning "named pipe" (fifo) device
Date: Fri, 27 Feb 2004 17:09:04 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I realize this is somewhat off topic, but this is
for an app that runs in an embedded PPC Linux system.
I am working with code from the VxWorks world; my
question is: how can I find out how many bytes there
are "queued up" in a named pipe (i.e what is the
"size" of the fifo "file")? In Vxworks, it's done
like this:

ioctl(fd, FIONMSGS, &nMessages);
  - copies to nMessages the number of discrete messages remaining in the
    pipe refered to by 'fd'

There does not appear to be any similar ioctl()
functionality in Linux for named pipes. I tried using
fstat(), but the 'st_size' field is always zero for a
named pipe. So does anyone have any advice on how
to find out how many bytes are in a named pipe?

Thanks.

Erik Teose
erik.teose@tek.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
