From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: RE: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith r128
Date: Sat, 4 Mar 2000 13:55:34 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
References: <Pine.LNX.4.21.0003041753480.1870-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003041753480.1870-100000@idd-01.imbc.gr>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00030413590600.00885@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Kostas,

Here is the patch to fix the cursor for 16bpp and 8bpp for XFree 4.0 r128. (It
is attached). It is almost exactly what you sent to me earlier.

By the way, true 16 bit depth (565) does not work on my machine. The screen
comes up but everything is very very green!

Reverting to 16bpp and 15 depth (555) works fine.

I hope this one makes it into the XFree 4.0 final.

Thanks,

Kevin



--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="be_cursor.patch.gz"
Content-Disposition: attachment; filename="be_cursor.patch.gz"
Content-Transfer-Encoding: base64

H4sICL5bwTgAA2JlX2N1cnNvci5wYXRjaADVlPFvmkAUx38uf8VLmyzggcChzOlc7CwxJpttqM26
tIYgHJXMqblTq1m6v30H6ERUarcl294P4OM+9+77nu+eoiiw8NQJHT9Q9ytTbxmhc0LVwaO6CCgh
FVP1aci/MJXquBI/HG9G2ZgWveKEkvnJtTuFjy4FKIGOqwault8A1jRNQAj9euytsEa1VK5iMwnb
aIBimrKuA4per6HREOAsHHnDmU/gNI5CyUNxcCpAtBDArfP+c9dyLu0Ly4Z6PfLbLcfqXLTPO4Jy
5pMgHBFY2ZVz/en8SgQXZOiDBGm7F5TVL1H0BlxcQXKlO60H9c2HvnRn9GqHaT1L4zwaZ2l9TaO1
7kSwgfdLXsHHy94PH1C9Hz4g+l6APbCRhbWegLLZ6ebh7NIq8hOMZRyAdxLUcuCdBI0ceCdB3ONt
SUZ+GEQNGvezrldkbADScUkua3FHJ8Vi7pzw7e2ObbVEO2rtpt1tOi2r4zQ73Q9SLcEub7r7ATmJ
8Aq+b9aaNzZvfr41brhgTEFc8jO0GizhLZgl/kZIgm88nWPuT+bi+DJbh47MR6gGjD/+Jhj/L+wx
nHoDMRwFY+XdJFyQodNfTglLMk3McxmBUnXbNzb+c/VK2897mcjaXsxo+y82PaWdPiXul9p2ofDv
FIpf8ZfL/zc35RSKTzV3NpymC3VsnQr8LE4VdiX+wZWV9KdoQg0Zib0cgXCyFedFrrKegatz0+4z
8ywae1yi8AMfQSLHvggAAA==

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
