Return-Path: <anton@samba.org>
Date: Tue, 15 Oct 2013 14:55:43 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Use 32 bit loads and stores when operating on
 condition register values
Message-ID: <20131015145543.736684c3@kryten>
In-Reply-To: <20131015034206.GB17233@drongo>
References: <20131015143631.1879607c@kryten>
	<20131015034206.GB17233@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Paul,

> Does this make any practical difference or fix any bugs, or is this
> just for aesthetics?

There is talk of the other 32 bits of that word being used for a
stack canary in a future ABI revision. So right now it is just
cosmetic, but it could be important in the future.

I guess it could be an issue for kgdb since the CR will be in
the wrong spot on BE.

Anton
