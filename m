Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 66987DDE36
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 13:25:49 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so61758wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 20:25:48 -0700 (PDT)
Message-ID: <fa686aa40708212025m87e2f12idfd260976b3c4851@mail.gmail.com>
Date: Tue, 21 Aug 2007 21:25:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Woodworth" <rwoodworth@securics.com>
Subject: Re: [PATCH 3/3] Add support for xupv2p and ml410 boards.
In-Reply-To: <1187751864.6266.6.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1187743993171-git-send-email-wolfgang.reissnegger@xilinx.com>
	<1187743993360-git-send-email-wolfgang.reissnegger@xilinx.com>
	<20070822005048.CF66B31005A@mail77-blu.bigfish.com>
	<1187751864.6266.6.camel@PisteOff>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/21/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> Should the xparameters????.h file *really* be included in the tree?
>
> This file is completely board/EDK/ISE/synthesis specific.  I'd rather it
> not be included and have people copy theirs from EDK.
> Or as I have done, sym-link it from my EDK project.

Including xparams for the default xilinx reference designs seems
reasonable to me.  For custom designs, not so much.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
