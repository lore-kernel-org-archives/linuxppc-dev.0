From: tom_gall@vnet.ibm.com
Message-ID: <397D8157.E4E94657@vnet.ibm.com>
Date: Tue, 25 Jul 2000 12:00:23 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Donald Cowart <dcowart@acld.lib.fl.us>
CC: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: RTAS on PowerMac Newworld
References: <Pine.LNX.4.20.0007250756370.31668-100000@bookworm.acld.lib.fl.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Donald Cowart wrote:
>
> Newbie question, what is RTAS?

RTAS == Run-Time Abstraction Services

In a nutshell an API the OS may utilize to perform various tasks which without
RTAS would be hardware dependant. For example: reading the level on a battery on
a portable, and so on.

> Donald Cowart  (dcowart@acld.lib.fl.us)


--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
