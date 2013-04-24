Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: "attempt to move .org backwards" still show up
In-reply-to: <51779941.8080403@linux.vnet.ibm.com>
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Wed, 24 Apr 2013 20:37:38 +1000
Message-ID: <30651.1366799858@ale.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, matt@ozlabs.org, gang.chen@asianux.com,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:

> =E4=BA=8E 2013/4/24 16:31, Michael Ellerman =E5=86=99=E9=81=93:
> > On Wed, Apr 24, 2013 at 04:22:53PM +0800, Mike Qiu wrote:
> >> Hi all
> >>
> >> I get an error message when I compile the source code in Power7 platfo=
rm
> >> use the newest upstream kernel.
> > Hi Mike,
> >
> > It depends on what your .config is. What defconfig are you building?
> I just copy the config file from /boot/config.* to .config and use make
> menuconfig
> change nothing by manually, then save.

Can you post the resulting config here?

Do you have commit in your tree?
  commit 087aa036eb79f24b856893190359ba812b460f45
  Author: Chen Gang <gang.chen@asianux.com>
  powerpc: make additional room in exception vector area

Mikey
