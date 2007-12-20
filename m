Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 09C31DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 02:42:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so937574anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:42:41 -0800 (PST)
Message-ID: <fa686aa40712200742i89a2ca9p60365b06adc426c@mail.gmail.com>
Date: Thu, 20 Dec 2007 08:42:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andy Whitcroft" <apw@shadowen.org>
Subject: Re: [PATCH] [RFC] Xilinx SystemACE: Add media hotplug support
In-Reply-To: <20071220144532.GA27885@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220062348.16448.24575.stgit@trillian.secretlab.ca>
	<20071220144532.GA27885@shadowen.org>
Cc: axboe@kernel.dk, monstr@monstr.eu, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/20/07, Andy Whitcroft <apw@shadowen.org> wrote:
> On Wed, Dec 19, 2007 at 11:23:48PM -0700, Grant Likely wrote:
>
> > +             /* Make the sysace device 'live' */
> > +             if (ace->fsm_state != ACE_FSM_STATE_INVALIDATE_MEDIA);
> > +                     add_disk(ace->gd);
>
> checkpatch.pl reports the above if as suspect due to the trailing ;.
> Looks wrong to me too.

Ah, good catch.

Thanks.
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
