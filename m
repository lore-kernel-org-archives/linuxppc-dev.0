Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <E1PgKdi-0005fc-J5@jdl.com>
References: <E1Pd18R-0002d3-US@jdl.com>
	<20110121171314.GD7477@angua.secretlab.ca>
	<E1PgKdi-0005fc-J5@jdl.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 21 Jan 2011 10:28:57 -0700
Message-ID: <AANLkTi=bHV9XJoUT_ki1Eziq5fM3DekrOLoFuNzGGv91@mail.gmail.com>
Subject: Re: [PATCH] Globally s/struct irq_host/struct irq_domain/
To: Jon Loeliger <jdl@jdl.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 21, 2011 at 10:19 AM, Jon Loeliger <jdl@jdl.com> wrote:
>>
>> For this to make sense, it really needs to also rename irq_host_ops
>> structure, the IRQ_HOST_MAP* #defines, and the irq_*_host functions.
>> It also /should/ adjust the users of irq_domain to rename function
>> local variables and structure members. =A0Otherwise there will be an
>> even worse mismatch in naming.
>
> Happy to do so, but last time we talked about this, we decided
> not to do *that* aspect of the rename with this patch, and that
> we'd get to it later with follow on patches once this step was done.

I always reserve the right to change my mind.  }:->  Sorry about that,
but I actually applied the patch this morning with the thought that
I'd get Linus to pick it up late to avoid collisions in linux-next.
However, when I actually looked at the result I realized that at the
very least, the irq_host_ops, the #defines, and the irq_*_host
functions absolutely have to be renamed at the same time.  Not
necessarily in the same patch, but definitely at the same time.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
