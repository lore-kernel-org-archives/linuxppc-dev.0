Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20120201141705.GF9587@linutronix.de>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-23-git-send-email-grant.likely@secretlab.ca>
 <20120128164405.GA20763@linutronix.de>
 <20120130195842.GT28397@ponder.secretlab.ca>
 <20120201141705.GF9587@linutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Feb 2012 11:06:04 -0700
Message-ID: <CACxGe6vZxWXUG-WJFWDaoH3+PYBGWOXb291_jn9TdjrSF=p_JQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/25] irq_domain/x86: Convert x86 (embedded) to use
 common irq_domain
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 1, 2012 at 7:17 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Grant Likely | 2012-01-30 12:58:42 [-0700]:
>
>>Ugh. =A0This isn't easy. =A0The legacy mapping really needs all the
>
> Feel free to merge this patch. I don't have the time to look at this now
> so I take a look at the ioapic later.

There's no rush here.  I can leave it as-is with IRQ_DOMAIN turned off
for x86 for now.

g.
