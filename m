Date: Tue, 9 Apr 2002 14:01:30 -0700
From: Matt Porter <mporter@mvista.com>
To: sanjay k k <fren00@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anybody able to build linux kernel for PPC440?
Message-ID: <20020409140130.A2114@home.com>
References: <20020409051614.7827.qmail@mailFA3.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020409051614.7827.qmail@mailFA3.rediffmail.com>; from fren00@rediffmail.com on Tue, Apr 09, 2002 at 05:16:14AM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 05:16:14AM -0000, sanjay k k wrote:
>
> Hi folk,
> Anybody is able build the linux kernel for PPC440 using
> linux_2_4_devel tree. I tried but i got few unresolved error?
>
> Any help will be greatly appreicated.

Ok, I've committed the build fix for ibm_ocp_enet.c and a number
of 440 fixes.  The current _devel is what you want to work with
at this point.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
