Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66FF6DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 09:56:33 +1000 (EST)
Message-ID: <471944A8.6050803@genesi-usa.com>
Date: Sat, 20 Oct 2007 00:58:32 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>	<20071019112916.GE27403@nd47.coderock.org>
	<fa686aa40710190609jebd4e31q9240d2ff5b4a5d47@mail.gmail.com>
In-Reply-To: <fa686aa40710190609jebd4e31q9240d2ff5b4a5d47@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 10/19/07, Domen Puncer <domen.puncer@telargo.com> wrote:
>> On 17/10/07 10:36 -0600, Grant Likely wrote:
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> Only the MPC5200 needs this bug fix.  MPC5200B is okay.
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>>
>>> Sven, Domen;
>>>
>>> Can you please test this patch?
>> I found no obvious problems with it on Efika (mpc5200b)
> 
> Cool, I'll add it to my list of patches for Paulus to pull

See now that wasn't so hard was it? :D

You earned a cookie :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
