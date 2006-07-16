Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 527EA67B5E
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 09:09:45 +1000 (EST)
Date: Sun, 16 Jul 2006 18:09:15 -0500
To: Luke Browning <LukeBrowning@us.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060716230915.GA5497@pb15.lixom.net>
References: <20060716035353.GA5266@pb15.lixom.net>
	<OFFBAD5953.E17A24C8-ON832571AD.007DA01D-832571AD.007DBBB5@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFFBAD5953.E17A24C8-ON832571AD.007DA01D-832571AD.007DBBB5@us.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Bryan S Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 16, 2006 at 08:53:21PM -0200, Luke Browning wrote:

> > Just so people don't forget: this can't be done on all processors. For
> > example, PPC970 and POWER4 don't implement the PURR SPR. And it doesn't
> > make sense to use H_PURR to get the software emulated ones there. Not
> > really an issue on POWER4 since they don't do shared processor LPAR, but
> > on JS21 I think they might do?
> > 
> Isn't there someway to do a platform specific processor overlay, where you 
> get PURR if it exists and TB otherwise.

Sure, it's what we have cpu feature bits for. It's not a difficult
problem to solve, I was just reminding of the lack of SPRN_PURR on some
processors that can run hypervisors.


-Olof
