From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Halfmann, Klaus" <khalfmann@libra.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of hfs support as of 2.4.0-test1-ac21
Date: Fri, 23 Jun 2000 14:27:38 +0200
Message-Id: <20000623122738.30313@mailhost.mipsys.com>
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDD30@mail.libra.de>
References: <F14441D40E5AD3118886005004607AD10BDD30@mail.libra.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 23, 2000, Halfmann, Klaus <khalfmann@libra.de> wrote:

>
>I found however some bugs not related to hfs and may reproduce
>them in detail in case someone asks:
>  - the console driver messed up some pixels while editing
>  - hdparm did not always work correctly
>    (I use pmud and it calls hdparm depending on the battery load)
>    Sometimes I got stuck with the message "hda interrupt lost"
>    or similar.

That's interesting. Could you give me more details about what you do
excatly with hdparm that is causing the lost interrupt ? Can you try to
use it manually (without pmud) and reproduce the problem ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
