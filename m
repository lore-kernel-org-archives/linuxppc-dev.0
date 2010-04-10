Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id EA24CB7D15
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 09:47:28 +1000 (EST)
Received: by gwb11 with SMTP id 11so1915653gwb.15
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 16:47:27 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100410233909.GA16099@linux-sh.org>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
	<4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 10 Apr 2010 17:47:07 -0600
Message-ID: <k2ufa686aa41004101647md1e8cfbfw85c5b98b9613cd2d@mail.gmail.com>
Subject: Re: A better way to sequence driver initialization?
To: Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bill Gatliff <bgat@billgatliff.com>,
	linux-embedded <linux-embedded@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 10, 2010 at 5:39 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> In cases where you can specifically note that dependencies, doing so will
> save you a world of pain. Despite that, it's simply not possible to do
> this as a free-for-all. Devices or busses that can tolerate multi-threaded
> probing need to be converted over one at a time, but even then you still
> need the dependency tracking for those that depend on link order today.

Well stated.

g.
