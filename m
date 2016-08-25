Return-Path: <michael.heltne@gmail.com>
Received: from mail-it0-x232.google.com (mail-it0-x232.google.com
 [IPv6:2607:f8b0:4001:c0b::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKTgG5ZTKzDrK4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 13:09:46 +1000 (AEST)
Received: by mail-it0-x232.google.com with SMTP id f6so69194165ith.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 20:09:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
From: Mike <michael.heltne@gmail.com>
Date: Thu, 25 Aug 2016 05:09:43 +0200
Message-ID: <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
To: "Herminio Hernandez Jr." <herminio.hernandezjr@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a11446af8c4b635053adcba4e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11446af8c4b635053adcba4e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Any improvement on your ends? Seems -1 is now the quirk. But does your
trackpads work? Did an update after getting a new and the latest released
powerbook up. Also found an interesting interface which can replace our ide
drives, intended for ipod classics, but it can fit in the bay and has msata
interface.

On 5 Feb 2016 15:32, "Herminio Hernandez Jr." <
herminio.hernandezjr@gmail.com> wrote:

> I have been experiencing the same thing with my iBook and PowerBook.
>
> Sent from my iPhone
>
> On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
>
> Hi.
> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> patch from Michel D=C3=A0nzer, next problem is of course enabling agpmode=
,
> running with pci-mode with radeon.agpmode=3D-1 works, but is of course sl=
ow,
> and seems to load the cpu a lot.
>
> Upon initial investigation i could not initially believe agp could be thi=
s
> this broken for this long, until i found this.
>  "committed with Ben Skeggs on Feb 26, 2013"
> https://github.com/DespairFactor/bullhead/commit/
> 650e1203c11354ba84d69ba445abc0efcfe3890a
> http://lxr.free-electrons.com/source/drivers/gpu/drm/
> nouveau/nouveau_agp.c?v=3D4.2
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for
> * now -- At least some UniNorth-2 AGP bridges are
> * known to be broken: DMA from the host to the card
> * works just fine, but writeback from the card to the
> * host goes straight to memory untranslated bypassing
> * the GATT somehow, making them quite painful to deal
> * with...
> */
> if (nouveau_agpmode =3D=3D -1)
> return false;
> #endif
>
>  and now later this:
> https://github.com/torvalds/linux/blob/master/drivers/gpu/
> drm/nouveau/nvkm/subdev/pci/agp.c
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for now -- At
> * least some UniNorth-2 AGP bridges are known to be broken:
> * DMA from the host to the card works just fine, but writeback
> * from the card to the host goes straight to memory
> * untranslated bypassing that GATT somehow, making them quite
> * painful to deal with...
> */
> mode =3D 0;
> #endif
>
> All seems to point to serious issues had around the time of change to ums
> to kms and a serious regression hitting the linux kernel? No?
>
> Cheers
> -Mike
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>

--001a11446af8c4b635053adcba4e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Any improvement on your ends? Seems -1 is now the quirk. But=
 does your trackpads work? Did an update after getting a new and the latest=
 released powerbook up. Also found an interesting interface which can repla=
ce our ide drives, intended for ipod classics, but it can fit in the bay an=
d has msata interface. </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 5 Feb 2016 15:=
32, &quot;Herminio Hernandez Jr.&quot; &lt;<a href=3D"mailto:herminio.herna=
ndezjr@gmail.com">herminio.hernandezjr@gmail.com</a>&gt; wrote:<br type=3D"=
attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div>I have b=
een experiencing the same thing with my iBook and PowerBook.=C2=A0<br><br>S=
ent from my iPhone</div><div><br>On Feb 4, 2016, at 8:47 PM, Mike &lt;<a hr=
ef=3D"mailto:michael.heltne@gmail.com" target=3D"_blank">michael.heltne@gma=
il.com</a>&gt; wrote:<br><br></div><blockquote type=3D"cite"><div><div dir=
=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_extra">Hi.=C2=A0</d=
iv><div class=3D"gmail_extra">Managed to get the Radeon R300 running on mes=
a 11.1.1 with an old 2013 patch from Michel D=C3=A0nzer, next problem is of=
 course enabling agpmode, running with pci-mode with radeon.agpmode=3D-1 wo=
rks, but is of course slow, and seems to load the cpu a lot.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Upon initial investi=
gation i could not initially believe agp could be this this broken for this=
 long, until i found this.</div><div class=3D"gmail_extra"><div class=3D"gm=
ail_extra">=C2=A0&quot;committed with Ben Skeggs on Feb 26, 2013&quot;</div=
><div class=3D"gmail_extra"><a href=3D"https://github.com/DespairFactor/bul=
lhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a" target=3D"_blank">ht=
tps://github.com/<wbr>DespairFactor/bullhead/commit/<wbr>650e1203c11354ba84=
d69ba445abc0<wbr>efcfe3890a</a></div></div><div class=3D"gmail_extra"><a hr=
ef=3D"http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_=
agp.c?v=3D4.2" target=3D"_blank">http://lxr.free-electrons.com/<wbr>source/=
drivers/gpu/drm/<wbr>nouveau/nouveau_agp.c?v=3D4.2</a></div><div class=3D"g=
mail_extra">#ifdef __powerpc__</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">		</span>/* Disable AGP by default on all PowerPC=
 machines for</div><div class=3D"gmail_extra"><span style=3D"white-space:pr=
e-wrap">		</span> * now -- At least some UniNorth-2 AGP bridges are</div><d=
iv class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</span> * k=
nown to be broken: DMA from the host to the card</div><div class=3D"gmail_e=
xtra"><span style=3D"white-space:pre-wrap">		</span> * works just fine, but=
 writeback from the card to the</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">		</span> * host goes straight to memory untransl=
ated bypassing</div><div class=3D"gmail_extra"><span style=3D"white-space:p=
re-wrap">		</span> * the GATT somehow, making them quite painful to deal</d=
iv><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</span=
> * with...</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-=
wrap">		</span> */</div><div class=3D"gmail_extra"><span style=3D"white-spa=
ce:pre-wrap">		</span>if (nouveau_agpmode =3D=3D -1)</div><div class=3D"gma=
il_extra"><span style=3D"white-space:pre-wrap">			</span>return false;</div=
><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extra">=C2=A0</=
div><div class=3D"gmail_extra">=C2=A0and now later this:=C2=A0</div><div cl=
ass=3D"gmail_extra"><a href=3D"https://github.com/torvalds/linux/blob/maste=
r/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c" target=3D"_blank">https://=
github.com/torvalds/<wbr>linux/blob/master/drivers/gpu/<wbr>drm/nouveau/nvk=
m/subdev/pci/<wbr>agp.c</a></div><div class=3D"gmail_extra">#ifdef __powerp=
c__</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	<=
/span>/* Disable AGP by default on all PowerPC machines for now -- At</div>=
<div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * =
least some UniNorth-2 AGP bridges are known to be broken:</div><div class=
=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * DMA from t=
he host to the card works just fine, but writeback</div><div class=3D"gmail=
_extra"><span style=3D"white-space:pre-wrap">	</span> * from the card to th=
e host goes straight to memory</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">	</span> * untranslated bypassing that GATT someh=
ow, making them quite</div><div class=3D"gmail_extra"><span style=3D"white-=
space:pre-wrap">	</span> * painful to deal with...</div><div class=3D"gmail=
_extra"><span style=3D"white-space:pre-wrap">	</span> */</div><div class=3D=
"gmail_extra"><span style=3D"white-space:pre-wrap">	</span>mode =3D 0;</div=
><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">All seems to point to serious issues had aroun=
d the time of change to ums to kms and a serious regression hitting the lin=
ux kernel? No?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">Cheers</div><div class=3D"gmail_extra">-Mike</div></div></div>
</div></blockquote><blockquote type=3D"cite"><div><span>___________________=
___________<wbr>_________________</span><br><span>Linuxppc-dev mailing list=
</span><br><span><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D=
"_blank">Linuxppc-dev@lists.ozlabs.org</a></span><br><span><a href=3D"https=
://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https://lists.=
ozlabs.org/<wbr>listinfo/linuxppc-dev</a></span></div></blockquote></div></=
blockquote></div></div>

--001a11446af8c4b635053adcba4e--
