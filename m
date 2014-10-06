Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5])
 by lists.ozlabs.org (Postfix) with ESMTP id 926651A0318
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 05:21:53 +1100 (EST)
Message-ID: <1412619708.14236.2.camel@x220>
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
From: Paul Bolle <pebolle@tiscali.nl>
To: Geoff Levand <geoff@infradead.org>
Date: Mon, 06 Oct 2014 20:21:48 +0200
In-Reply-To: <1412616877.32313.55.camel@smoke>
References: <cover.1408731991.git.geoff@infradead.org>
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
 <20140825172234.GD14379@redhat.com> <1409402838.21896.99.camel@x220>
 <1412604734.4054.72.camel@x220> <1412616877.32313.55.camel@smoke>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: maximilian attems <max@stro.at>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-06 at 10:34 -0700, Geoff Levand wrote:
> On Mon, 2014-10-06 at 16:12 +0200, Paul Bolle wrote:
> > It seems not much happened after I added my Acked-by. I assume you still
> > want to get this merged. Is that correct?
> 
> Yes, I think we concluded there are no real users of this kexec_load()
> ptototype, and so it can be removed.

What would be the quickest way to get this finally resolved? Who's in
charge of this stuff? Would resending your patch, with my Ack added,
speed up things? The vain side of my personality does think it would
help.


Paul Bolle
