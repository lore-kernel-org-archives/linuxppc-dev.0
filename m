Date: Fri, 05 May 2000 02:43:25 +0200
Subject: Re : 5 button mouse and XFree86 vers 4
From: "Florent" <flobo@iname.com>
To: Andrew Thompson <lordpixel@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20000504224403.5E5A528E66@postfix1.free.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


----------
>Andrew Thompson <lordpixel@mac.com> wrote:



> What I'm trying to do now is get all 5 buttons working on my Kensington
> Mouseworks USB mouse.

3 buttons and 2 for the wheel ?

> I tried adding this lines to my XF86Config
>         Option      "Buttons" "5"
>
> But no dice. Has anytone had any luck with > 3 buttons so far?

Yes, I am using a Logitech USB wheel mouse and it works great with a few
softwares (especially gtk-based ones)


> Can someone enlighten me as to the story with USB mice on linux ppc? Are we
> somehow shimying them so they appear as PS/2 or ADB?
> Why isn't USB support on in the above RPMs? If I get the source RPM and
> build it myself can I turn in on maybe?

Since kernel 2.2.10 (if i remember), the USB mouse driver tries to emulate
an IMPS/2 mouse (PS/2 Microsoft intellimouse), that is, 3 buttons and a
wheel. So there is no need for softwares to support anything else than
IMPS/2 to make use of your USB mouse.

Here is what is written in my XF86Config file to make use of my wheel:
    ZAxisMapping    4 5
    Buttons         3

There is a little software called imwheel that allows the user to program
the 4th and 5th button usage for applications that do not make use of them.

Florent

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
