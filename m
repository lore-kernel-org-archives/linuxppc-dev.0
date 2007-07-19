Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:27:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: Do we need to reset the master branch?
Message-Id: <20070720012708.91c77527.sfr@canb.auug.org.au>
In-Reply-To: <20070719151746.GB20538@mag.az.mvista.com>
References: <20070719151746.GB20538@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mark,

On Thu, 19 Jul 2007 08:17:46 -0700 "Mark A. Greer" <mgreer@mvista.com> wrote:
>
> I did a git-pull this morning but it had a conflict.  Should I have
> reset it to something?

What did you pull it into?  There were conflicts with Linus' tree in the
last merge, so there may be conflicts with master as well.  I am sure
Paul will pull Linus's tree back into his master branch when he returns
which should resolve the conflicts.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
