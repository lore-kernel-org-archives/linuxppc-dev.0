Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 10 Oct 2008 02:10:02 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] [NAND] driver extension to support NAND on TQM85xx
	modules
Message-ID: <20081009221002.GA2257@oksana.dev.rtsoft.ru>
References: <484CE77C.70506@grandegger.com> <486B39C8.10502@grandegger.com>
	<48EE5EAE.1090105@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EE5EAE.1090105@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 09:42:38PM +0200, Wolfgang Grandegger wrote:
> Wolfgang Grandegger wrote:
> > Hello,
> > 
> > I would like to ask for the status of the patch below and the related
> > ones. Any chance to get them in for 2.6.27.
> 
> Already sometime ago I asked for the status of these patches but I never
> got an answer and they did make it into 2.6.27, like the related patches
> from Anton. That's really disappointing. What do I need to do to get
> them finally accepted?

You should keep resending the patches till somebody merge them. ;-)

As for my patches... David, could you please apply that patch:

http://lists.infradead.org/pipermail/linux-mtd/2008-September/023038.html

?

IIRC Wolfgang's patches depend on it.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
