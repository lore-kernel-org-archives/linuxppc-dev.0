Return-Path: <bigeasy@linutronix.de>
Date: Wed, 1 Feb 2012 15:17:05 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 22/25] irq_domain/x86: Convert x86 (embedded) to use
 common irq_domain
Message-ID: <20120201141705.GF9587@linutronix.de>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-23-git-send-email-grant.likely@secretlab.ca>
 <20120128164405.GA20763@linutronix.de>
 <20120130195842.GT28397@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20120130195842.GT28397@ponder.secretlab.ca>
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

* Grant Likely | 2012-01-30 12:58:42 [-0700]:

>Ugh.  This isn't easy.  The legacy mapping really needs all the

Feel free to merge this patch. I don't have the time to look at this now
so I take a look at the ioapic later.

>g.

Sebastian
