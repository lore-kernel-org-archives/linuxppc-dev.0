Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1260413279.306784.161998452424.1.gpush@pororo>
References: <1260413279.306784.161998452424.1.gpush@pororo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 00:09:24 -0700
Message-ID: <fa686aa40912102309y3b0882ddn90bb95c8ab0ae62d@mail.gmail.com>
Subject: Re: [PATCH] of: merge of_find_node_by_phandle
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 7:47 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Merge common function between powerpc, sparc and microblaze. Code is
> identical for powerpc and microblaze, but adds a lock (and release) of
> the devtree_lock on sparc.
>
> Currently untested.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Added to my test branch.  We'll see how it shakes out.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
