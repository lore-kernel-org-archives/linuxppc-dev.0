From: Amit.Lubovsky@infineon.com
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E4856@ntah901e.savan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: pci on MBX860 broken ?
Date: Tue, 7 Oct 2003 10:49:28 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
As I understand from Dan the pci code for the MBX860 is probably broken and
not used
so my question now is does anyone has some info that can direct me about how
to fix this
code ?, in general I know that there isn't any hw problem since we have it
working for vxWorks...
any help is appreciated.
Amit.

-----Original Message-----
From: Dan Kegel [mailto:dank@kegel.com]
Sent: Sunday, October 05, 2003 7:07 PM
To: Lubovsky Amit (IFSV R&D)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci on MBX860


Amit.Lubovsky@infineon.com wrote:
>>Does anyone have any experience with pci on the MBX860 board ?
>>
>>I run kernel 2.4.20 from www.denx.de but encountered compilation problems
>>after trying to configure pci.
>>
>>this is the output of what I got:  ...
>>m8xx_setup.c: In function `m8xx_show_percpuinfo':
>>m8xx_setup.c:252: warning: int format, long int arg (arg 3)
>>m8xx_setup.c:252: warning: int format, long int arg (arg 4)
>>m8xx_setup.c: In function `m8xx_init_IRQ':
>>m8xx_setup.c:281: structure has no member named `irq_offset'

(caveat: I'm just a google junky, I don't know this stuff)

Didn't work last time somebody tried it a year ago, either.
See the thread from last year:
http://www.geocrawler.com/mail/msg.php3?msg_id=8600995&list=8358
http://www.geocrawler.com/mail/msg.php3?msg_id=8601123&list=8358
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
