Return-Path: <paulus@ozlabs.org>
Date: Tue, 15 Oct 2013 14:42:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Use 32 bit loads and stores when operating on
 condition register values
Message-ID: <20131015034206.GB17233@drongo>
References: <20131015143631.1879607c@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131015143631.1879607c@kryten>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 15, 2013 at 02:36:31PM +1100, Anton Blanchard wrote:
> 
> The condition register (CR) is a 32 bit quantity so we should use
> 32 bit loads and stores.

Does this make any practical difference or fix any bugs, or is this
just for aesthetics?

Paul.
