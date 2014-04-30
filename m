Return-Path: <paulus@ozlabs.org>
Date: Wed, 30 Apr 2014 16:29:42 -0500
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv: Reduce pseries panic timeout from 180s
 to 10s
Message-ID: <20140430212942.GC9671@iris.ozlabs.ibm.com>
References: <20140501072004.5b694f54@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140501072004.5b694f54@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 01, 2014 at 07:20:04AM +1000, Anton Blanchard wrote:
> We've already dropped the default pseries timeout to 10s, do
> the same for powernv.

Why is there "pseries" in the patch subject rather than "powernv"?

Paul.
