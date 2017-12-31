Return-Path: <sascha.schroeder@aethyx.com>
Date: Mon, 01 Jan 2018 00:26:19 +0100
In-Reply-To: <1a034ec1-5345-a2a1-780a-b5adbe0af332@freebsd.org>
References: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
 <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
 <4dadeca5-22dc-6ab1-961e-8f989b6f8699@freebsd.org>
 <5c41fd34-5aac-028e-af12-59b6ab576d91@infradead.org>
 <1a034ec1-5345-a2a1-780a-b5adbe0af332@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----77CXZ8C38VPR3B91OH2LPB9KOPHJKB"
Subject: Re: Getting kernel 4.14 to run on PS3
To: Nathan Whitehorn <nwhitehorn@freebsd.org>,
 Geoff Levand <geoff@infradead.org>
CC: Linuxppc-dev@lists.ozlabs.org,petitboot@lists.ozlabs.org
From: Sascha Schroeder <sascha.schroeder@aethyx.com>
Message-ID: <93E9535C-CB24-454E-8F56-E5C7588AEFEF@aethyx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------77CXZ8C38VPR3B91OH2LPB9KOPHJKB
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sounds like progress! Nice one!

I encountered several issues with this box but still believe Cell can do m=
ore=2E

We're at an incredible architecture right here, what concerns me most is t=
hat we still today miss the availability of the mightyness of this machine=
=2E

Gallium 0=2E2 is still working for example, what we need here is people to=
 bring this stuff further=2E

Heck, I have 7 SPEs on this machine, time to do something useful with thes=
e!

220Gflops FTW!=20

Am 31=2E Dezember 2017 23:50:14 MEZ schrieb Nathan Whitehorn <nwhitehorn@f=
reebsd=2Eorg>:
>
>
>On 12/12/17 15:05, Geoff Levand wrote:
>> Hi Nathan,
>>
>> On 12/08/2017 01:25 PM, Nathan Whitehorn wrote:
>>> I submitted patches to libfdt that resolve this particular ABI
>breakage yesterday=2E If the patch gets merged, newer kernels should
>become bootable again=2E
>> Here's the link:
>>
>>    https://github=2Ecom/dgibson/dtc/pull/12 (Add limited read-only
>support for older (V2 and V3) device tree to libfdt=2E)
>>
>> I rebased your patch and have it in my ps3-queue
>> branch, but my ps3 with ps3-petitboot-09=2E11=2E30 still
>> would not boot with it=2E  I didn't spend any time yet
>> to look into why=2E
>>
>>  =20
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/geoff/ps3-linux=2Egit=
/log/?h=3Dps3-queue
>>
>> -Geoff
>>
>
>I found a bug (and updated the pull request), which might help=2E
>
>The other potential issue is that the fdt_get_property*() API in libfdt
>
>is fundamentally incompatible with the way that V2 device trees align=20
>data accesses since it returns a pointer to a packed structure with
>both=20
>the property header and data=2E However, the data in V2 devtrees may be=
=20
>offset by 4 bytes in a way that depends both on the offset within the=20
>tree and the length of the property and so cannot be represented only
>as=20
>the tail of a fixed structure=2E I don't know if Linux uses those=20
>functions; I had to replace two uses in FreeBSD with the equivalent=20
>fdt_getprop*() calls to get things to work=2E
>-Nathan

------77CXZ8C38VPR3B91OH2LPB9KOPHJKB
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Sounds like progress! Nice one!<br>
<br>
I encountered several issues with this box but still believe Cell can do m=
ore=2E<br>
<br>
We&#39;re at an incredible architecture right here, what concerns me most =
is that we still today miss the availability of the mightyness of this mach=
ine=2E<br>
<br>
Gallium 0=2E2 is still working for example, what we need here is people to=
 bring this stuff further=2E<br>
<br>
Heck, I have 7 SPEs on this machine, time to do something useful with thes=
e!<br>
<br>
220Gflops FTW! <br><br><div class=3D"gmail_quote">Am 31=2E Dezember 2017 2=
3:50:14 MEZ schrieb Nathan Whitehorn &lt;nwhitehorn@freebsd=2Eorg&gt;:<bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail"><br /><br />On 12/12/17 15:05, Geoff Levand wrote:<b=
r /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E8ex;=
 border-left: 1px solid #729fcf; padding-left: 1ex;"> Hi Nathan,<br /><br /=
> On 12/08/2017 01:25 PM, Nathan Whitehorn wrote:<br /><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid =
#ad7fa8; padding-left: 1ex;"> I submitted patches to libfdt that resolve th=
is particular ABI breakage yesterday=2E If the patch gets merged, newer ker=
nels should become bootable again=2E<br /></blockquote> Here's the link:<br=
 /><br />    <a href=3D"https://github=2Ecom/dgibson/dtc/pull/12">https://g=
ithub=2Ecom/dgibson/dtc/pull/12</a> (Add limited read-only support for olde=
r (V2 and V3) device tree to libfdt=2E)<br /><br /> I rebased your patch an=
d have it in my ps3-queue<br /> branch, but my ps3 with ps3-petitboot-09=2E=
11=2E30 still<br /> would not boot with it=2E  I didn't spend any time yet<=
br /> to look into why=2E<br /><br />    <a href=3D"https://git=2Ekernel=2E=
org/pub/scm/linux/kernel/git/geoff/ps3-linux=2Egit/log/?h=3Dps3-queue">http=
s://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/geoff/ps3-linux=2Egit/log/?=
h=3Dps3-queue</a><br /><br /> -Geoff</blockquote><br /><br />I found a bug =
(and updated the pull request), which might help=2E<br /><br />The other po=
tential issue is that the fdt_get_property*() API in libfdt <br />is fundam=
entally incompatible with the way that V2 device trees align <br />data acc=
esses since it returns a pointer to a packed structure with both <br />the =
property header and data=2E However, the data in V2 devtrees may be <br />o=
ffset by 4 bytes in a way that depends both on the offset within the <br />=
tree and the length of the property and so cannot be represented only as <b=
r />the tail of a fixed structure=2E I don't know if Linux uses those <br /=
>functions; I had to replace two uses in FreeBSD with the equivalent <br />=
fdt_getprop*() calls to get things to work=2E<br />-Nathan<br /></pre></blo=
ckquote></div></body></html>
------77CXZ8C38VPR3B91OH2LPB9KOPHJKB--
