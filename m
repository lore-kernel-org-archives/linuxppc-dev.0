Date: Thu, 30 May 2002 17:10:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Locke <mlocke@mvista.com>,
	Dan Malek <dan@embeddededge.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
Message-ID: <20020531001005.GD32412@opus.bloom.county>
References: <20020529030838.GZ16537@zax> <3CF4E842.3070207@embeddededge.com> <15605.24191.948013.249297@argo.ozlabs.ibm.com> <3CF581BE.8020207@embeddededge.com> <3CF64E9C.60303@mvista.com> <15606.47823.449239.651529@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15606.47823.449239.651529@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 31, 2002 at 09:50:39AM +1000, Paul Mackerras wrote:
>
> > btw, there are bugs with it.  Starting several processes with init or
> > even telnetd will expose the bug.
>
> David and I haven't been able to reproduce this on the Walnut or the
> EP405.  What sort of machine are you using, what processor, how much
> RAM, and what distro are you using?

A Walnut (pvr: 40110145) with 32mb of RAM and Debian/Woody shows it off
quite nicely here.

Login via serial, telnet to localhost, login, do it again.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
