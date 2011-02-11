Return-Path: <meadori@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4D54986A.60907@mentor.com>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
	<4D54986A.60907@mentor.com>
Date: Thu, 10 Feb 2011 21:26:07 -0600
Message-ID: <AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
From: Meador Inge <meadori@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Apologies for the bad post. =A0Bad day for email ... =A0Please ignore the
top reply in my previous reply. =A0The full reply is the below the
quote.

On Thu, Feb 10, 2011 at 8:01 PM, Meador Inge <meador_inge@mentor.com> wrote=
:
>
> On 02/10/2011 02:42 PM, Meador Inge wrote:
>>
>> ---------- Forwarded message ----------
>> From: Meador Inge<meador_inge@mentor.com>
>> Date: Fri, Feb 4, 2011 at 5:25 PM
>> Subject: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
>> To: linuxppc-dev@lists.ozlabs.org
>> Cc: devicetree-discuss@lists.ozlabs.org, Hollis Blanchard<
>> hollis_blanchard@mentor.com>
>>
>>
>> This patch set provides a binding for Open PIC and implements support fo=
r
>> a new property, specified by that binding, called "pic-no-reset". =A0Wit=
h
>> "pic-no-reset" in place the "protected-sources" property is no longer ne=
eded
>> and its full implementation was removed. =A0"protected-sources" is still
>> checked
>> for, however, for legacy purposes.
>>
>> For v3 of this patch the Open PIC binding was changed to be more consist=
ent
>> with existing bindings, several DTS files were cleaned up, "no-reset" wa=
s
>> changed to "pic-no-reset", and a check to treat "protected-sources" as a
>> synonym for "pic-no-reset" was added.
>>

>From the feedback I have received so far, the fundamental ideas in
this patch set are sane. =A0However, the following issues
still need agreement:

 =A0 =A01. What should be the name of the no reset property?
 =A0 =A0 =A0 "pic-no-reset" or "no-reset"?
 =A0 =A02. Should we just keep the existing protected sources implementatio=
n
 =A0 =A0 =A0 in place?

For (1), I prefer "no-reset". =A0For (2), I still think that we can make
"no-reset" a synonym for "protected-sources" and that things will work
out.

Ben, you said that you would really like to leave the protected
sources implementation alone. =A0Is the mechanism implemented in "PATCH
v3 3/4" [1] of having "protected-sources" as a synonym for
"pic-no-reset" not suitable?

[1] http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088262.htm=
l

 --
Meador Inge =A0 =A0 | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
