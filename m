To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 MCC Interrupt priority 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Sep 2002 19:00:27 +0200."
             <000701c258eb$9092e4e0$0700a8c0@pc005>
Date: Tue, 10 Sep 2002 20:12:05 +0200
Message-Id: <20020910181210.43370FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gianfranco,

in message <000701c258eb$9092e4e0$0700a8c0@pc005> you wrote:
>
> Many thanks for your suggestion, I have checked the references You gave me
> and I believe that RTAI would be a good solution to solve our problem.
> Actually I'm working with a quite old version of HardHat package (CDK 1.2
> with 2.4.0-test2 kernel) with some minor patches in order to have the
> ethernet 100% functionality, do You think we can easily port the RTAI on
> this version or shall we migrate to HardHat 2.0?

You will run into problems with a 2.4.0 kernel.  But  that  does  not
mean  that  you  have  to  use HHL 2.0. The kernel source tree is one
thing, the (cross) development toolchain is a  different  issue,  and
the  native  tools  used for the target is yet another story. OK, the
(cross) development toolchain and the native  tools  are  related  in
some  ways  -  at  least  they should use the same versions of shared
libraries, etc.

But you can easily  use  a  more  recent  kernel  source  tree  while
continuing  to use the your current tools - if there is nother reason
to change.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
They weren't that important. They were merely at the top. The  people
who  really  run organizations are usually found several levels down,
where it's still possible to get things done.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
