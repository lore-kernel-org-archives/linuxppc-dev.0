Date: Fri, 12 Mar 2004 08:20:23 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
Message-ID: <20040312162023.GA24851@gate.ebshome.net>
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com> <20040312045451.GA25876@gate.ebshome.net> <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 12, 2004 at 08:25:23AM -0600, Kumar Gala wrote:
>
> Look in u-boot.  They have some user commands that allow
> reading/writing dcr's.  These commands are written with self modifying
> code, I would recommend that we reuse that.
>

I would not.

Kumar, I'm aware of code in u-boot :).
Did you read this code comment ?

It clearly states that is not efficient.
It may be OK for a boot loader, because nobody cares much about it
performance.

Let me repeat my point. I _do_ know how to write self-modifying code,
I don't _like_ this approach mostly because it's not very efficient.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
