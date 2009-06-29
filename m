Return-Path: <jacmet@gmail.com>
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Jorge =?utf-8?Q?S=C3=A1nchez?= de Nova <j.s.denova@gmail.com>
Subject: Re: Device tree for c67x00
References: <621779fd0906290825i6bdc1e99tf6be68e3de56e9a6@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 29 Jun 2009 21:10:14 +0200
In-Reply-To: <621779fd0906290825i6bdc1e99tf6be68e3de56e9a6@mail.gmail.com>
	("Jorge =?utf-8?Q?S=C3=A1nchez?= de Nova"'s message of "Mon\,
	29 Jun 2009 17\:25\:16 +0200")
Message-ID: <871vp2eu09.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Jorge" =3D=3D Jorge S=C3=A1nchez de Nova <j.s.denova@gmail.com> writ=
es:

 Jorge> Hi,

 Jorge> It doesn't work at all since it doesn't load anything. I have
 Jorge> looked at the driver and there is apparently no openfirmware
 Jorge> support for it, so maybe the dts info won't work without
 Jorge> it. Am I wrong? Does this means that the c67x00 needs OF
 Jorge> support to work in this configuration? How can I make it
 Jorge> otherwise?

Yes, the c67x00 driver doesn't currently have any OF bindings. Either
you can add it, or simply manually create the struct platform_device
in your board file (or scan the DT in your board file and fill in the
correct base address / interrupt number from it).

Remember that arch/powerpc uses virtual interrupt numbers if you're
going to fill in the platform_device by hand.

--=20
Bye, Peter Korsgaard
