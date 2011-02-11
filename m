Return-Path: <meador_inge@mentor.com>
Message-ID: <4D54986A.60907@mentor.com>
Date: Thu, 10 Feb 2011 20:01:14 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
In-Reply-To: <AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


 From the feedback I have received so far, the fundamental ideas in this 
patch set are sane.  However, the following issues are still outstanding:

     1. What is the name of the no reset property?
        "pic-no-reset" or "no-reset"?
     2. Should we just keep the existing protected sources implementation
        in place?

For (1), I am fine with either.  For (2), I still think that we can make 
"pic-no-reset" a synonym for "protected-sources" and that things will 
work out.

On 02/10/2011 02:42 PM, Meador Inge wrote:
> ---------- Forwarded message ----------
> From: Meador Inge<meador_inge@mentor.com>
> Date: Fri, Feb 4, 2011 at 5:25 PM
> Subject: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
> To: linuxppc-dev@lists.ozlabs.org
> Cc: devicetree-discuss@lists.ozlabs.org, Hollis Blanchard<
> hollis_blanchard@mentor.com>
>
>
> This patch set provides a binding for Open PIC and implements support for
> a new property, specified by that binding, called "pic-no-reset".  With
> "pic-no-reset" in place the "protected-sources" property is no longer needed
> and its full implementation was removed.  "protected-sources" is still
> checked
> for, however, for legacy purposes.
>
> For v3 of this patch the Open PIC binding was changed to be more consistent
> with existing bindings, several DTS files were cleaned up, "no-reset" was
> changed to "pic-no-reset", and a check to treat "protected-sources" as a
> synonym for "pic-no-reset" was added.
>

 From the feedback I have received so far, the fundamental ideas in this 
patch set are sane.  However, the following issues still need agreement:

     1. What should be the name of the no reset property?
        "pic-no-reset" or "no-reset"?
     2. Should we just keep the existing protected sources implementation
        in place?

For (1), I prefer "no-reset".  For (2), I still think that we can make 
"no-reset" a synonym for "protected-sources" and that things will work out.

Ben, you said that you would really like to leave the protected sources 
implementation alone.  Is the mechanism implemented in "PATCH v3 3/4" 
[1] of having "protected-sources" as a synonym for "pic-no-reset" not 
suitable?

[1] http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088262.html

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
