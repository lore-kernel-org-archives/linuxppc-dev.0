In-Reply-To: <37D8DE44.9AE2C717@ssl.co.uk>
Date: Fri, 10 Sep 1999 13:59:35 +0200
To: Sacha Varma <sacha@ssl.co.uk>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: altivec
Message-Id: <19990910135935.015493@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 10, 1999, Sacha Varma <sacha@ssl.co.uk> wrote:

>There was some talk of trapping an illegal instruction interrupt in
>Altivec-compiled code on non-Altivec processors and then emulating it in
>software, but as I recall this was thought to be maybe impossible (due to
>limited information about the illegal instruction and limits on what you can
>do
>in the trap) or more effort than it's worth.

This is possible since Apple provides an emulator for developers (it's an
extension that you drop in your MacOS system folder and which traps the
illegal instruction interrupt).

>In the meantime to learn more about Altivec I've been working on a library to
>emulate the instructions in software (with appropriate #defines for the
>language
>extensions in a header). If anyone's interested e-mail me and I'll let you
>know
>if/when I'm done; I'm hoping to get the bulk of it done this weekend. (It'll
>be
>C++ I'm afraid - the vector types lend themselves nicely to a template class,
>and a lot of the vec_* instructions are overloaded).

If your library can be turned into plain C, then we should be able to
implement the same emulation mecanism in Linux, but is it really
interesting ? It will be way too slow to be useful for anything but
developers prototyping Altivec code on G3s.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
