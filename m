Date: Mon, 7 Apr 2003 11:47:17 +1000
From: Erik Christiansen <erik@dd.nec.com.au>
To: Mark Hatle <fray@mvista.com>
Cc: Darin.Johnson@nokia.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib
Message-ID: <20030407014717.GA742@dd.nec.com.au>
References: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com> <3E8E31AD.3050302@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E8E31AD.3050302@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 04, 2003 at 07:30:21PM -0600, Mark Hatle wrote:
> I strongly recommend you stay away from newlib.

Mark,

   Is it something related to linux that has given you a bad experience
   with newlib? (There is no related information in your post, so I'm
   curious.)

   We are using newlib on a bare-bones ppc board, with every success.
   We've trialled the library in both dynamically relocatable form, and
   statically linked.

   An exerpt from the cross-gcc FAQ helps clarify when you might use it:
>>>
   Licensing
      Glibc is covered by the LGPL (the GNU Library General Public License).
   Newlib is a collection of software from several sources, each with their own
   copyrights, but basically it's a Berkeley style copyright.

   Resource Utilization
      Glibc, being intended for native Unix environments, does not need to worry
   about memory usage as much. It is designed to work most efficiently in
   demand-page-loaded shared library situations. Newlib, being intended for
   embedded systems, does worry about memory usage (and is more memory-efficient
   than glibc).
<<<

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
