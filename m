Message-Id: <99Nov12.095336ast.7306@dragon.appliedmicro.ns.ca>
Date: Fri, 12 Nov 1999 09:52:42 -0400
From: Frank Smith <frank.smith@amirix.com>
MIME-Version: 1.0
To: Frank Smith <frank.smith@aeat.co.uk>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MVME2600
References: <s82c1723.097@a-hgwd3.harwell.aeat.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Smith wrote:
> 
> Does anybody know of Linux on Motorola VME cards MVME2600?  Where can I find such a beast?
> 
> Thanks
> 
> Frank


Hi Frank Smith:

This is quite funny. We have the same name, and you want to do
what I did a couple of weeks ago.

I found a patch for the Linux kernel at Motorola:

http://services.mcg.mot.com/linux/Main/linux_welcome.cfm

It took a bit of tweaking, but I got it netbooting from
PPCBug, using an initial ramdisk. Hint: don't use the
tulip ethernet driver. I used the PReP kernel, and had
to set PPCbug to enable PReP booting. 

There might be other ways to do this, but this method
worked for me. 

Frank Smith



> 
> ***********************************************************************
> This transmission contains information which may be confidential and
> which may also be privileged.  It is intended for the named addressee
> only.  Unless you are the named addressee, or authorised to receive it
> on behalf of the addressee you may not copy or use it, or disclose it
> to anyone else.  If you have received this transmission in error please
> contact the sender.  Thank you for your cooperation.
> ***********************************************************************

-- 
Frank Smith, MCompSci
Principal Software Designer      frank.smith@amirix.com
AMIRIX Systems Inc.              http://www.amirix.com/
77 Chain Lake Drive              902-450-1700 x289 (Phone)
Halifax, N.S. B3S 1E1            902-450-1704 (FAX)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
