Return-Path: <corbet@lwn.net>
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KDj03PhtzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 03:27:28 +1000 (AEST)
Date: Mon, 2 Jul 2018 11:27:23 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho
 Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jacek
 Anaszewski <jacek.anaszewski@gmail.com>, devicetree@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, linux-kernel@zh-kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, linux-leds@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Mark Rutland <mark.rutland@arm.com>,
 linux-gpio@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, James
 Morris <james.morris@microsoft.com>, Jeff Kirsher
 <jeffrey.t.kirsher@intel.com>, Changbin Du <changbin.du@intel.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, linux-input@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy
 Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/9] Fix references for some missing documentation files
Message-ID: <20180702112723.654d348c@lwn.net>
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jun 2018 06:49:02 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Having nothing to do while waiting for my plane to arrive while
> returning back from Japan, I ended by writing a small series of 
> patches meant to reduce the number of bad Documentation/* 
> links that are detected by:
> 	./scripts/documentation-file-ref-check

I've applied everything except the two networking patches, since I expect
those to go through Dave's tree.

Thanks,

jon
