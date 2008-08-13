Return-Path: <plasmaroo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id E9D10DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 16:06:28 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5555995wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 23:06:27 -0700 (PDT)
Message-ID: <792f5f410808122306u478b3ere8167016ef892323@mail.gmail.com>
Date: Wed, 13 Aug 2008 07:06:27 +0100
From: "Tim Yamin" <plasm@roo.me.uk>
Sender: plasmaroo@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <fa686aa40808122302g197a8e90idc721796aa35ff05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DD39B5C3F4963040ADC9768BE7E430CB03202F4F@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A7B@is-hdq-exchange.marel.net>
	<792f5f410808120643md72e679o39692c4bfa3f285e@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A94@is-hdq-exchange.marel.net>
	<792f5f410808120730j7b4be4f2n7a40de880178ccca@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203ADC@is-hdq-exchange.marel.net>
	<792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>
	<792f5f410808122257t3711eb2lfc1e02bacade16a3@mail.gmail.com>
	<fa686aa40808122302g197a8e90idc721796aa35ff05@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 13, 2008 at 7:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> While on this topic; have you had a chance to address the comments you
> received on v2 of your patch?  I'm keen to get your change merged in,
> but there are a few more things that need to be sorted out.

I'm still trying to determine whether the locking stuff is needed or
not. I think ultimately it might be a bug caused by hardware problems
at this end as opposed to silicon problems affecting everybody, but I
won't have an answer regarding this for a while because new hardware
needs to be prototyped to test out this theory.

I think the patch can probably be resubmitted with the locking stuff
removed, and the driver can be marked as experimental for everybody to
try out: if people experience any corruption problems I'm sure they
can speak up :-)

Any objections?

Tim
