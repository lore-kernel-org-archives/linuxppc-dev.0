Return-Path: <sebastien.chretien.enseirb@gmail.com>
Message-ID: <319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
Date: Mon, 18 Aug 2008 13:35:35 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [MPC7448] machdep_calls
In-Reply-To: <319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2345_12324990.1219059335827"
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2345_12324990.1219059335827
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Can somebody explain me the aim of the function  "setup_arch" in the
machine_call structure ?

2008/8/18, S=E9bastien Chr=E9tien <sebastien.chretien.enseirb@gmail.com>:
>
> Ok I am going to copy some examples.
>
> 2008/8/18, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>>
>> On Mon, 2008-08-18 at 10:45 +0200, S=E9bastien Chr=E9tien wrote:
>> > Hello,
>> >
>> > I am developping a Linux for my PPC Board. I must write a
>> > define_machine structure (marchdep_calls). Where can I find some
>> > Information about functions of this structure ?
>>
>>
>> It isn't well documented unfortunately. Best is to look at what others
>> do... and then find your way through.
>>
>> I agree somebody should write dome doco one day ... in the meantime,
>> feel free to ask questions here.
>>
>> Cheers,
>> Ben.
>>
>>
>>
>

------=_Part_2345_12324990.1219059335827
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Can somebody explain me the aim of the function&nbsp; &quot;setup_arch&quot=
; in the machine_call structure ?<br><br><div><span class=3D"gmail_quote">2=
008/8/18, S=E9bastien Chr=E9tien &lt;<a href=3D"mailto:sebastien.chretien.e=
nseirb@gmail.com">sebastien.chretien.enseirb@gmail.com</a>&gt;:</span><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ok I am going to copy some examples.<br><br><div><span class=3D"gmail_quote=
">2008/8/18, Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.crash=
ing.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,even=
t,this)">benh@kernel.crashing.org</a>&gt;:</span><div>
<span class=3D"e" id=3D"q_11bd58db5862f0b8_1"><blockquote class=3D"gmail_qu=
ote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0p=
t 0.8ex; padding-left: 1ex;">
On Mon, 2008-08-18 at 10:45 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; H=
ello,<br> &gt;<br> &gt; I am developping a Linux for my PPC Board. I must w=
rite a<br> &gt; define_machine structure (marchdep_calls). Where can I find=
 some<br>

 &gt; Information about functions of this structure ?<br> <br> <br>It isn&#=
39;t well documented unfortunately. Best is to look at what others<br> do..=
. and then find your way through.<br> <br> I agree somebody should write do=
me doco one day ... in the meantime,<br>

 feel free to ask questions here.<br> <br> Cheers,<br> Ben.<br> <br> <br> <=
/blockquote></span></div></div><br>
</blockquote></div><br>

------=_Part_2345_12324990.1219059335827--
