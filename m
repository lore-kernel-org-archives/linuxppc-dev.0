Return-Path: <w90p710@gmail.com>
Message-ID: <52C0D251.2000400@gmail.com>
Date: Mon, 30 Dec 2013 09:54:25 +0800
From: wyang <w90p710@gmail.com>
MIME-Version: 1.0
To: Gavin Hu <gavin.hu.2010@gmail.com>, Linuxppc-dev@lists.ozlabs.org
Subject: Re: [question] Can the execution of the atomtic operation instruction
 pair lwarx/stwcx be interrrupted by local HW interruptions?
References: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>
In-Reply-To: <CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------030800000008060101080307"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030800000008060101080307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/2013 01:41 PM, Gavin Hu wrote:
> Hi
>
> I notice that there is a pair ppc instructions lwarx and stwcx used to 
> atomtic operation for instance, atomic_inc/atomic_dec.
>
> In some ppc manuals, they more emphasize its mechanism is that lwarx 
> can reseve the target memory address preventing other CORE from 
> modifying it.
>
> I assume that there is atomtic operation executing on the CORE0 in a 
> multicore system. In this situation, does the CORE0 disable the local 
> HW interrupt?
> Can the executing process from the beginning of lwarx and end of stwcx 
> be interrupted by HW interruptions/exceptions? Anyway, they are two 
> assembly instructions.

It should just like other arch, the processor should response any 
interrupt after the execution of a instruction, so the local HW 
interrupt is not disabled.

Thanks
Wei
>
>  Thanks a lot!
>
> "1:    lwarx    %0,0,%2        # atomic_inc\n\
>     addic    %0,%0,1\n"
> "    stwcx.    %0,0,%2 \n\
>
>
> BR
> Gavin. Hu
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------030800000008060101080307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 12/28/2013 01:41 PM, Gavin Hu wrote:<br>
    </div>
    <blockquote
cite="mid:CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">Hi <br>
        <div><br>
          I notice that there is a pair ppc instructions lwarx and stwcx
          used to atomtic operation for instance, atomic_inc/atomic_dec.<br>
          <br>
        </div>
        <div>In some ppc manuals, they more emphasize its mechanism is
          that lwarx can reseve the target memory address preventing
          other CORE from modifying it.<br>
          <br>
        </div>
        <div>I assume that there is atomtic operation executing on the
          CORE0 in a multicore system. In this situation, does the CORE0
          disable the local HW interrupt?<br>
        </div>
        <div>Can the executing process from the beginning of lwarx and
          end of stwcx be interrupted by HW interruptions/exceptions?&nbsp;
          Anyway, they are two assembly instructions.<br>
        </div>
      </div>
    </blockquote>
    <br>
    It should just like other arch, the processor should response any
    interrupt after the execution of a instruction, so the local HW
    interrupt is not disabled.<br>
    <br>
    Thanks<br>
    Wei<br>
    <blockquote
cite="mid:CABiPGEfmEFovARBy0rwjbDpBnVeRrmvQrxgnH+32z0RLUX3Nkw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <br>
          &nbsp;Thanks a lot!<br>
        </div>
        <div><br>
          "1:&nbsp;&nbsp;&nbsp; lwarx&nbsp;&nbsp;&nbsp; %0,0,%2&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; # atomic_inc\n\<br>
          &nbsp;&nbsp;&nbsp; addic&nbsp;&nbsp;&nbsp; %0,%0,1\n"<br>
          "&nbsp;&nbsp;&nbsp; stwcx.&nbsp;&nbsp;&nbsp; %0,0,%2 \n\<br>
          <br>
          <br>
        </div>
        <div>BR<br>
        </div>
        <div>Gavin. Hu<br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030800000008060101080307--
