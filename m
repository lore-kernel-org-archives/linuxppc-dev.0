Message-ID: <3C4592C3.6072A2B0@lvl7.com>
Date: Wed, 16 Jan 2002 09:48:35 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: device private ioctls and their future
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hell all-
	I was adding a device private ioctl to an ethernet driver of ours under
the 2.4.14 kernel and when I went to lookup the name of the first
private device ioctl in include/linux/sockios.h I find a big note right
at the device private section indicating that the device private ioctls
are depricated and will dissappear in the 2.5 kernel.  Can anyone
describe to me what will be taking the place of this ioctl values, if
any?  Much appreciated!
Neil :)
--
/***************************************
*Neil Horman
*Master of Software Feng Shui
*Lvl7 Systems
*(919)-865-2915
***************************************/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
