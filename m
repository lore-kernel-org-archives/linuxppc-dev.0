Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbMTg6sQlzF0yG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 22:21:08 +1100 (AEDT)
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: mad skateman <madskateman@gmail.com>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com> <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com> <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <1d62c827-0ff7-0372-a2f8-f1930e9f788c@xenosoft.de>
Date: Tue, 6 Feb 2018 12:20:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have tried to figure out why there is a problem with the buffer space 
but unfortunately without any success. Any ideas? Could you please watch 
Skateman's video? [1]

Thanks,
Christian

[1] https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view


On 03 February 2018 at 12:54PM, mad skateman wrote:
 >
 > For those interested... i have recorded a video of my X5000 DPAA 
Ethernet, and the weird problems..
 > In this Video i am also transfering hundereds of megabytes from my 
NAS to the X5000.
 > You will also see pings die... mostly after the 12th packet and 
giving the no buffer space error..
 > Hopefully someone might have a clue about what is happening.
 >
 > https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view
 >
 > On Wed, Jan 17, 2018 at 3:43 PM, Madalin-cristian Bucur 
<madalin.bucur@nxp.com> wrote:
 >
 >     > -----Original Message-----
 >     > From: Madalin-cristian Bucur
 >     > Sent: Wednesday, January 17, 2018 4:25 PM
 >     > To: David S . Miller <davem@davemloft.net>
 >     > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
 >     > madskateman@gmail.com; 'Madalin-cristian Bucur' 
<madalin.bucur@nxp.com>;
 >     > Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
 >     > <Joakim.Tjernlund@infinera.com>
 >     > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
 >     >
 >     > > -----Original Message-----
 >     > > From: netdev-owner@vger.kernel.org 
[mailto:netdev-owner@vger.kernel.org]
 >     > > On Behalf Of Madalin-cristian Bucur
 >     > > Sent: Wednesday, January 17, 2018 4:16 PM
 >     > > To: Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
 >     > > <Joakim.Tjernlund@infinera.com>
 >     > > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
 >     > > madskateman@gmail.com; David S . Miller <davem@davemloft.net>
 >     > > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
 >     > >
 >     > > > -----Original Message-----
 >     > > > From: Andrew Lunn [mailto:andrew@lunn.ch]
 >     > > > Sent: Wednesday, January 17, 2018 3:44 PM
 >     > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
 >     > > > Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
 >     > > >
 >     > > > > That doesn't work really, having users to hit the bug, 
debug it, fix
 >     > > it
 >     > > > and then
 >     > > > > find it fixed already in upstream, then specifically 
request it to
 >     > be
 >     > > > backported to stable.
 >     > > > > I don't need this fix to be backported, already got it. 
Someone else
 >     > > > might though.
 >     > > >
 >     > > > The "someone else might though" is a big point of asking 
for it to
 >     > > > added to stable. The other reason is it means one less 
patch you need
 >     > > > to maintain in your build.
 >     > >
 >     > > I've sent that patch [1] for net but I guess the timing was 
wrong and
 >     > > it was merged to net-next.
 >     > >
 >     > > > > I would be interested in bug fixes upstream which fixes:
 >     > > >
 >     > > > Did you try upstream? Does it give the same errors?
 >     > > >
 >     > > >     Andrew
 >     > >
 >     > > [1] https://patchwork.kernel.org/patch/10146119/
 >     > >
 >     > > Madalin
 >     >
 >     > Hi Dave,
 >     >
 >     > Can you please add the fix [1] to stable?
 >     >
 >     > Thank you,
 >     > Madalin
 >
 >     Sorry,
 >
 >     I've provided the wrong link towards the patch (v1 instead of v3),
 >     here's the correct one:
 >
 >     https://patchwork.kernel.org/patch/10151969/
 >
 >     Madalin
 >
 >
