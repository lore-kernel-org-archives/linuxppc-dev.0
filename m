From: tom_gall@vnet.ibm.com
Message-ID: <397D7C3E.34DD37FC@vnet.ibm.com>
Date: Tue, 25 Jul 2000 11:38:38 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTAS on PowerMac Newworld
References: <397D6A7A.CBF58A52@francetelecom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


FASSINO Jean-Philippe wrote:
>
> Hello,
>
> Just a question about RTAS on PowerMac G4,
> does linux kernel can call RTAS function ?

Hi Jean-Philippe,

  You can call RTAS on a PowerMac but I wouldn't do it. From what I understand
Apple doesn't recommend that you make use of RTAS on their hardware.

  On RS/6000 hardware you most certainly can use RTAS.

> And if not, why ?
> I'm trying to do it and that fail...
>
> JP

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
