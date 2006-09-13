Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: William Chung <whchung@us.ibm.com>
Subject: Re: [Cbe-oss-dev] automount support
Date: Wed, 13 Sep 2006 21:12:40 +0200
References: <OFA201BCF4.3B7FA605-ON852571E8.0063942F-852571E8.00668E8E@us.ibm.com>
In-Reply-To: <OFA201BCF4.3B7FA605-ON852571E8.0063942F-852571E8.00668E8E@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609132112.41186.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 September 2006 20:40, William Chung wrote:
> autofs4 is supposedly backwardly compatible with autofs (v3), so I'd=20
> prefer autofs4. =A0I hear that having only autofs4 as a module can requir=
e=20
> adding the line "alias autofs autofs4" to /etc/modprobe.conf to let=20
> modutils look for autofs4 when the kernel needs autofs. =A0I'm not sure t=
hat=20
> this line is necessary though because I built a kernel with both autofs=20
> and autofs4 enabled as modules and it looks like only autofs4 gets loaded=
,=20
> without any changes to my /etc/modprobe.conf file. =A0Hopefully, someone=
=20
> more experienced with autofs can give some guidance here.

Ok, I've enabled it now internally. I have just released 2.6.18-rc7-arnd13,
which doesn't have it, but the next version will.

	Arnd <><
