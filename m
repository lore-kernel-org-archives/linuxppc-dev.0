Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zcars04e.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DF2C8DE056
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 08:12:45 +1000 (EST)
Message-ID: <48349E52.50605@nortel.com>
Date: Wed, 21 May 2008 16:12:34 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Subject: Re: patch to install unstripped vDSO on disk breaks powerpc kernel
	build
References: <482486F7.3090805@nortel.com>
	<20080509194427.3BDB126FA85@magilla.localdomain>
	<482527F3.60405@nortel.com>
	<20080511004047.2B6E226FA86@magilla.localdomain>
In-Reply-To: <20080511004047.2B6E226FA86@magilla.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath wrote:
> Ok.  That looks like a bug in the older binutils (objcopy) you are using.
> It is confused by the empty .rela.dyn section right next to the .dynamic
> section.  Current binutils don't seem to have a problem with this.
> 
> I haven't tried to get an old binutils running to reproduce this.
> I suspect the following change will work around the problem.
> It should not cause any problem with newer or older binutils.

Thanks, this seems to have fixed the problem.

Chris
