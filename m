Message-Id: <200102221712.MAA15343@odonnell.lowell.mclinux.com>
To: linuxppc-embedded@lists.linuxppc.org
From: mod+linuxppc-embedded@world-f.std.com
Subject: Re: do md5sums differ across architectures?
In-Reply-To: Your message of "Thu, 22 Feb 2001 11:03:45 EST."
             <200102221603.f1MG3k716096@ashley.ivey.uwo.ca>
Date: Thu, 22 Feb 2001 12:12:35 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Simple test cases: on both machines do

for string in \
   "" \
   "a" \
   "abc" \
   "message digest" \
   "abcdefghijklmnopqrstuvwxyz" \
   "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" \
   "12345678901234567890123456789012345678901234567890123456789012345678901234567890"
do
    echo -n $string | md5sum
done


The results MUST be:

   d41d8cd98f00b204e9800998ecf8427e
   0cc175b9c0f1b6a831c399e269772661
   900150983cd24fb0d6963f7d28e17f72
   f96b697d7cb7938d525a2f31aaf161d0
   c3fcd3d76192e4007dfb496cca67e13b
   d174ab98d277d9f5a5611c2c9f419d9f
   57edf4a22be3c955ac49da2e2107b67a

...respectively, or it's broken.


SEE ALSO: RFC 1321

 (e.g. http://rfc.asuka.net/rfc/rfc1321.html )


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
