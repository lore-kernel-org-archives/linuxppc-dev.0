Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 4 Jun 2013 13:16:52 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
Message-ID: <20130604031651.GA3373@thor.bakeyournoodle.com>
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com>
 <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <51AD45A4.9080702@princeton.edu>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
> On 6/3/2013 8:01 PM, Tony Breeds wrote:
> >On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:
> >
> >>>Device tree struct  0x0000000004820000 -> 0x0000000004840000
> >>>Calling quiesce...
> >>>returning from prom_init
> >>>[    1.376359] ehci-pci 0000:c8:01.2: can't setup
> >Can you try adding "debug" to the kernel commandline.  We're missing a
> >great chunk of detail. If you're starting from scratch either try F18 or
> >the F19 Beta (if you're brave :))
> >
> >Yours Tony
> So, two points.  Since I have no live disks, I can't copy the dmesg
> output in dracut onto a disk and just sent it to you -- the only way
> that I know to get it is cut and paste from a HMC console window
> into a vi buffer.

Okay, when I've been in that situation, I run "script" locally and then
conenct to the HMC console.

When you're done you can exit script adn then a file called typescript
will exist in the directory you ran script in.

It's a less overhead way of doign what you're already doing.
 [    0.087097] NET: Registered protocol family 16

> [    0.087144] pseries_eeh_init: RTAS service <ibm,get-config-addr-info2> and <i
> bm,get-config-addr-info> invalid
> [    0.087155] eeh_init: Failed to call platform init function (-22)

Hmm this seems pretty strange to me.  Gavin are these RTAS tokens
supported on older power5 boxes?


Yours Tony

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJRrVwjAAoJEEsCiJRY75GKkmQP/02IMsvnKxV8JAjVZfCTnbmW
F+BKTD5nsRLbRb5FUOPs62XwC79lcOGEIjvHg+LJBPEwPgRguOEkvJmlpl2tkgn3
aD3Mvi8j8A+IfcmYtruBtpO02R6KxMnEOj+eLUV5BTKxXvV+iccAVOg/BC7ud7SB
ogBTwccpJ9c5wkxZncivhMeOYecEZZt+TBAVjxrj3qvKoA3DBuaXI4islS68VdiA
Vo5/DzGggrXPiiXjUAbEhAd4nN5Mz4mzMLA/Ttx+lDDbWDounzW1JrtJp3qInhs1
VXkAIn95wotzbQG7O/cK8MiOKkdbMuK/geIQkV76HaQkrf+blfV7SIQJNJ/QQ0u6
I55Zx1hjTMRt+2DK5qExaqoPImAsCYfwVFe+9rtnhQyunJRm7LrfHlvoU6zuAeen
8t2iNr0LVxRJ/bSvKXGOum3exeE2i5EHXk4yBh5KLMBukuERK1PYkP98yjlFOmML
9NWjTTu7v+++CMeU+E9Kk/cxGzVsYs3xnHM46Hkerlals3sQsu5oPPBqz8MfhCZt
RvqZK942VApZ19+UjYn0s2SWrzM706TpJna1hAg/Ac7AIa4a6C1dlFdbXFRIfWM3
acdWs2zIKTnl++/l041n8LNOkMxCnObpsTuUdXTfAkyzskaaZ9XhjeEIaRDl+/Qu
5AFxKUxlsfKaXXk/HGvX
=01SH
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
