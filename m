Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <496A613F.5090901@ru.mvista.com>
Date: Mon, 12 Jan 2009 00:14:39 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/9] sl82c105: remove dead code
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
	<20090106183526.21193.24866.sendpatchset@localhost.localdomain>
In-Reply-To: <20090106183526.21193.24866.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> CONFIG_LOPEC and CONFIG_SANDPOINT config options are gone.
>   

  So these are gone with arch/ppc/?
  That's a pity -- MV has spent a lot of efforts on porting the latter 
to arch/powerpc/ but somehow it haven't got merged upstream. My patches 
ot this driver were actually due to it being used on Sandpoint. :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
