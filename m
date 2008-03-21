Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18403.31214.826941.838442@cargo.ozlabs.ibm.com>
Date: Fri, 21 Mar 2008 20:03:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> Confirmed, this patch fixes the problem.  Paulus or Kumar, can you
> please pick it up for .25?

Sure, will do.  I thought about putting it in the last batch but I
wanted an ack from you.

Anyone else got any last-minute things for 2.6.25?

Paul.
