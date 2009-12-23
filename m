Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1261532718.575722.541804401419.2.gpush@pororo>
References: <1261532718.575048.365032094903.0.gpush@pororo>
	<1261532718.575722.541804401419.2.gpush@pororo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Dec 2009 07:48:23 -0700
Message-ID: <fa686aa40912230648r3294e8f8m855ae91e490a9edd@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: make set_node_proc_entry private to
	proc_devtree.c
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 22, 2009 at 6:45 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> We only need set_node_proc_entry in proc_devtree.c, so move it there.
>
> This fixes the !HAVE_ARCH_DEVTREE_FIXUPS build, as we can't make make
> the definition in linux/of.h conditional on this #define (definitions in
> asm/prom.h can't be exposed to linux/of.h, due to the enforced #include
> ordering).
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

A little ugly, but it can probably be refactored and cleaned up later
(like a lot of other things in the merged code).  Otherwise these
three patches look good to me.  I've picked them up into my tree and
I'll push them out soon.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
