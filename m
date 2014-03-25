Return-Path: <w90p710@gmail.com>
Received: from mail-yh0-x22f.google.com (mail-yh0-x22f.google.com
 [IPv6:2607:f8b0:4002:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3BA1914008F
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2014 16:31:31 +1100 (EST)
Received: by mail-yh0-f47.google.com with SMTP id 29so6277814yhl.34
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2014 22:31:28 -0700 (PDT)
Message-ID: <533114A4.4080608@gmail.com>
Date: Tue, 25 Mar 2014 13:31:16 +0800
From: wyang <w90p710@gmail.com>
MIME-Version: 1.0
To: =?UTF-8?B?6K645LmF5oiQ?= <jiucheng.xu@hotmail.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: Ask for help about fsl ppc toolchian issue "Illegal instruction"
References: <BLU172-W4881D62A1C46E030116284FD650@phx.gbl>
In-Reply-To: <BLU172-W4881D62A1C46E030116284FD650@phx.gbl>
Content-Type: multipart/alternative;
 boundary="------------050405010902070200060306"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050405010902070200060306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/25/2014 10:17 AM, 许久成 wrote:
> Hi All,
>
> We run into an issue when use e500mc toolchain  g++ to compile c++ 
> code for p2020 platform,  the code as below:

Hmm, p2020 should be e500 core rather than e500mc. Additionally, you 
should use gdb to debug it, and check which instruction is illegal.

Thanks
Wei
>
>
> main.c
>
> #include <iostream>
> using namespace std;
>
> int main(void) {
>         cout << "asdfasdfasdfasdf";
>
>         return 0;
> }
>
> compile it with command "powerpc-fls-linux-g++ main.c" and the output 
> file's name is a.out, download the binary to p2020rdb board, but the 
> console prints the error log "Illegal instruction".
>
> It is all right on p2041 platform.
>
> The version of toolchian:
>
> Configured with: 
> /local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/work-shared/gcc-4.6.2+svnr180516-r29+fsl.6/gcc-4_6-branch/configure 
> --build=i686-linux --host=i686-fslsdk-linux --target=powerpc-fsl-linux 
> --prefix=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr 
> --exec_prefix=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr 
> --bindir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/bin/ppce500mc-fsl-linux 
> --sbindir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/bin/ppce500mc-fsl-linux 
> --libexecdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/libexec/ppce500mc-fsl-linux 
> --datadir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share 
> --sysconfdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/etc 
> --sharedstatedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/com 
> --localstatedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/var 
> --libdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/lib/ppce500mc-fsl-linux 
> --includedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/include 
> --oldincludedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/include 
> --infodir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share/info 
> --mandir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share/man 
> --disable-silent-rules --disable-dependency-tracking 
> --with-libtool-sysroot=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux 
> --with-gnu-ld --enable-shared --enable-languages=c,c++ 
> --enable-threads=posix --disable-multilib --enable-c99 
> --enable-long-long --enable-symvers=gnu --enable-libstdcxx-pch 
> --program-prefix=powerpc-fsl-linux- --enable-lto --enable-libssp 
> --disable-bootstrap --disable-libgomp --disable-libmudflap 
> --with-system-zlib --with-linker-hash-style=gnu 
> --enable-cheaders=c_global 
> --with-local-prefix=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux/usr 
> --with-gxx-include-dir=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux/usr/include/c++ 
> --with-build-time-tools=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-linux/usr/powerpc-fsl-linux/bin 
> --with-sysroot=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux 
> --with-build-sysroot=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/p4080ds 
> --disable-libunwind-exceptions --disable-libssp --disable-libgomp 
> --disable-libmudflap 
> --with-mpfr=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux 
> --with-mpc=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux 
> --enable-nls --enable-__cxa_atexit --with-long-double-128
> Thread model: posix
> gcc version 4.6.2 (GCC)
>
> Is e500mc family downward compitible with e500v2? C code can run 
> correctly on p2020 with the e500mc toolchain.
>
> Thanks & Best Regards
> Jiucheng
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------050405010902070200060306
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 03/25/2014 10:17 AM, 许久成 wrote:<br>
    </div>
    <blockquote cite="mid:BLU172-W4881D62A1C46E030116284FD650@phx.gbl"
      type="cite">
      <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:微软雅黑
}
--></style>
      <div dir="ltr">Hi All,
        <div><br>
        </div>
        <div>We run into an issue when use e500mc toolchain  g++ to
          compile c++ code for p2020 platform,  the code as below:</div>
      </div>
    </blockquote>
    <br>
    Hmm, p2020 should be e500 core rather than e500mc. Additionally, you
    should use gdb to debug it, and check which instruction is illegal.<br>
    <br>
    Thanks<br>
    Wei<br>
    <blockquote cite="mid:BLU172-W4881D62A1C46E030116284FD650@phx.gbl"
      type="cite">
      <div dir="ltr">
        <div><br>
        </div>
        <div><br>
        </div>
        <div>main.c</div>
        <div><br>
        </div>
        <div>
          <div>#include &lt;iostream&gt;</div>
          <div>using namespace std;</div>
          <div><br>
          </div>
          <div>int main(void) {</div>
          <div>        cout &lt;&lt; "asdfasdfasdfasdf";</div>
          <div><br>
          </div>
          <div>        return 0;</div>
          <div>}</div>
        </div>
        <div><br>
        </div>
        <div>compile it with command "powerpc-fls-linux-g++ main.c" and
          the output file's name is a.out, download the binary to
          p2020rdb board, but t<span style="font-size: 12pt;">he console
            prints the error log "Illegal instruction".</span></div>
        <div><br>
        </div>
        <div>It is all right on p2041 platform. </div>
        <div><br>
        </div>
        <div>The version of toolchian:</div>
        <div><br>
        </div>
        <div>
          <div>Configured with:
            /local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/work-shared/gcc-4.6.2+svnr180516-r29+fsl.6/gcc-4_6-branch/configure
            --build=i686-linux --host=i686-fslsdk-linux
            --target=powerpc-fsl-linux
            --prefix=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr
            --exec_prefix=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr
            --bindir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/bin/ppce500mc-fsl-linux
            --sbindir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/bin/ppce500mc-fsl-linux
            --libexecdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/libexec/ppce500mc-fsl-linux
            --datadir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share
            --sysconfdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/etc
            --sharedstatedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/com
            --localstatedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/var
            --libdir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/lib/ppce500mc-fsl-linux
            --includedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/include
            --oldincludedir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/include
            --infodir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share/info
            --mandir=/opt/fsl/1.2/sysroots/i686-fslsdk-linux/usr/share/man
            --disable-silent-rules --disable-dependency-tracking
            --with-libtool-sysroot=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux
            --with-gnu-ld --enable-shared --enable-languages=c,c++
            --enable-threads=posix --disable-multilib --enable-c99
            --enable-long-long --enable-symvers=gnu
            --enable-libstdcxx-pch --program-prefix=powerpc-fsl-linux-
            --enable-lto --enable-libssp --disable-bootstrap
            --disable-libgomp --disable-libmudflap --with-system-zlib
            --with-linker-hash-style=gnu --enable-cheaders=c_global
            --with-local-prefix=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux/usr
            --with-gxx-include-dir=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux/usr/include/c++
            --with-build-time-tools=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-linux/usr/powerpc-fsl-linux/bin
            --with-sysroot=/opt/fsl/1.2/sysroots/ppce500mc-fsl-linux
            --with-build-sysroot=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/p4080ds
            --disable-libunwind-exceptions --disable-libssp
            --disable-libgomp --disable-libmudflap
            --with-mpfr=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux
            --with-mpc=/local/workspace/yocto-iso-make/p4080ds/build_p4080ds_release/tmp/sysroots/i686-nativesdk-fslsdk-linux
            --enable-nls --enable-__cxa_atexit --with-long-double-128</div>
          <div>Thread model: posix</div>
          <div>gcc version 4.6.2 (GCC) </div>
        </div>
        <div><br>
        </div>
        <div>Is e500mc family downward compitible with e500v2? C code
          can run correctly on p2020 with the e500mc toolchain.</div>
        <div><br>
        </div>
        <div>Thanks &amp; Best Regards</div>
        <div>Jiucheng</div>
        <div><br>
        </div>
        <div> </div>
        <div><br>
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

--------------050405010902070200060306--
