Return-Path: <hollisb@us.ibm.com>
Subject: Re: update: consolidated flat device tree code
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1155860626.27466.126.camel@basalt.austin.ibm.com>
References: <1155860626.27466.126.camel@basalt.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 19:29:21 -0500
Message-Id: <1155860961.27466.129.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: Pantelis Antoniou <pantelis@embeddedalley.com>,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 19:23 -0500, Hollis Blanchard wrote:
> Changes:
> - converted some ints to "unsigned", since gcc was generating warnings
> and negative lengths don't make sense in the flat data structure.
> - added ft_set_prop(), which doesn't yet resize properties but will in
> the future.
> - added an explicit copyright statement.
> 
> Still haven't looked to merge Matt's changes (because I'm busy, the
> current code works for me, and they haven't been accepted in u-boot
> yet).
> 
> Current users: Xen
> Future users: Mark's Linux bootwrapper code
> Potential users: kexec, u-boot

Forgot to add that dtc itself is a potential user of this code.

-- 
Hollis Blanchard
IBM Linux Technology Center
