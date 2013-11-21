Return-Path: <anton@samba.org>
Date: Thu, 21 Nov 2013 14:33:34 +1100
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the final tree (Linus'
 tree related - powerpc)
Message-ID: <20131121143334.44be4231@kryten>
In-Reply-To: <20131121134622.a853064a1b5a8355e5077737@canb.auug.org.au>
References: <20131121134622.a853064a1b5a8355e5077737@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> <stdin>:1:0: error: -mcall-aixdesc must be big endian

Urgh, allyesconfig is building an LE kernel. Ian: do we need to reverse
the polarity of the option, and call it CONFIG_CPU_BIG_ENDIAN?

Anton
