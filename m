Message-Id: <5.1.0.14.2.20020205141523.01d9f650@falcon.si.com>
Date: Tue, 05 Feb 2002 14:23:27 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 8260 Software Watchdog Timer and Linux Apps
In-Reply-To: <000301c1ae75$8bd2f6f0$7d0110ac@Seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


8260 UM Section 4.3.2.8 (p. 4-35) "SYPCR can be read at any time but can be
written only once after system reset."  The SWTC (count) is in the SYPCR,
as well as the SWP (prescaler) and SWE (enable).

You can load it once.  After that you either live with it or take a reset
(at which time you are free to load it once again :-).

Note that it starts out life enabled and set with a maximum count.  If you
want it disabled, you have to explicitly do that.

gvb


At 01:47 PM 2/5/2002 -0500, barry.fisher wrote:

>Hello Everyone:
>In reading the 8260 documentation, it appears that once the 8260
>Software Watchdog timer is enabled, it cannot be disabled. Does anyone
>know whether the watchdog timer count(SWTC) can be loaded with a
>different value prior to the watchdog timer service sequence of 0x556C,
>0xAA39? Thanks in advance.
>Regards,
>Barry O. Fisher
>Seranoa Networks
>Email: barry.fisher@seranoa.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
