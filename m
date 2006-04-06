Return-Path: <ufz6@rz.uni-karlsruhe.de>
From: <bukhari@fzi.de>
Sender: "Amir Bukhari" <ufz6@rz.uni-karlsruhe.de>
To: "'Hans Thielemans'" <Hans.Thielemans@skynet.be>,
	<Linuxppc-embedded@ozlabs.org>
Subject: RE: Porting new MPC5200 based Board to linux kernel
Date: Thu, 6 Apr 2006 22:57:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.LNX.4.44.0604062158500.31146-100000@gandalf.inthazo.be>
Message-Id: <20060406205251.7511E67B16@ozlabs.org>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 
Hi Hans,
> Hi Amir,
> 
> Which MEN board is this? The EM01(A) or the PP01. 
I am using EM01A

> We are using the EM01A and have linux running.
> We always got reasonable fast response from the MEN support service.
> 
> If this does not work, I could send you my config file.
> 

That will be nice from you to send me that.

Is that config file what I need to get linux running, didn't I need any
board special code. Like tqm5xxx.c etc. which located on arch\ppc\platforms

Thanks,
-Amir

> Hans 
> 
> On Thu, 6 Apr 2006, Amir Bukhari wrote:
> 
> > We have a MEN mpc5200 base board and we want to get linux 
> running on it.
> > MEN has a bios and can load linux kernel and passing to 
> parameters. I 
> > have tried to configure kernel manualy but without success. 
> MEN bios 
> > load kernel, but nothing happend after that, I don't see 
> anything on console.
> > 
> > I am new in this area, I need a first working kernel so that I can 
> > implement other part.
> > I will need some guidnes.
> > Any help will be appretiated!!
> > 
> > -Amir
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> 
