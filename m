Return-Path: <geoff@infradead.org>
Message-ID: <1444412742.29301.90.camel@infradead.org>
Subject: Re: Time to remove platforms/cell?
From: Geoff Levand <geoff@infradead.org>
To: Marc Dietrich <marvin24@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org
Date: Fri, 09 Oct 2015 10:45:42 -0700
In-Reply-To: <1444327832.29301.27.camel@infradead.org>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2785247.ZjG8XMQlJP@fb07-iapwap2> <1443986839.20459.8.camel@infradead.org>
 <2232594.bcXLTZgZyv@fb07-iapwap2> <1444238423.29301.16.camel@infradead.org>
 <1444327832.29301.27.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Marc,

On Thu, 2015-10-08 at 11:10 -0700, Geoff Levand wrote:
> > On Mon, 2015-10-05 at 12:27 +0200, Marc Dietrich wrote:
> > > > I tried with ps3-queue and still no luck. Petitboot just says
> > > > "Booting kernel
> > > > ..." thats all - no output.
> > > > 
> > > > FW is 3.15 of course
> > > > Petitboot says (white-09.09.01-15.56)
> > 
> > I spent a few minutes on this, and it seems the 2nd stage kernel
> > panics when
> > setting up the SPUs.  You could try with CONFIG_SPU_FS=n.

With the 4.2-rc4 kernel, kexec seems to work when CONFIG_SPU_FS=n.  I
have not tried with petitboot release white-09.09.01-15.56 yet though.

-Geoff
