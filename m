Return-Path: <jgarzik@pobox.com>
Message-ID: <47E9CD2E.7040203@pobox.com>
Date: Wed, 26 Mar 2008 00:12:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/2] Two more pasemi_mac patches for 2.6.26
References: <20080326015625.GA23103@lixom.net>
In-Reply-To: <20080326015625.GA23103@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Hi Jeff,
> 
> The below two patches go on top of the previous patches that were acked
> by you but applied to pasemi.git for feed up through powerpc.git.
> 
> One is a couple of fixes for various corner cases in the jumbo support
> configuration. The second is addition of netpoll support, from Nate
> Case.
> 
> Review/ack would be appreciated, I'll feed them up the same path as the
> other changes.

ACK 1-2, though I would consider closely patch #2, whether you need 
disable_irq() or spin_lock_irqsave() -- which is best for your specific 
driver + platform?
