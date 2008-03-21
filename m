Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 73EC2DDFC8
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 05:51:57 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so355681anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 11:51:46 -0700 (PDT)
Message-ID: <fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
Date: Fri, 21 Mar 2008 12:51:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <47E3B4AF.3030505@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
	<47E3B4AF.3030505@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 7:14 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> Is the MPC5200B PSC-AC97 driver in there?

Audio drivers need to go in via one of the ALSA developers and I
haven't been paying close enough attention to know if it has not in
yet.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
